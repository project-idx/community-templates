import React, { useEffect, useRef, useState } from 'react';
import Image from "next/image";
import useOutsideClick from './hooks/useOutsideClick';
import { createRecipient, createEmail, getUidByEmail } from "@email-app/email";
import type { DataConnect } from 'firebase/data-connect';

interface Props {
  isOpen: boolean;
  onClose: () => void;
  uid: string;
  dc: DataConnect;
}

const ComposeModal = ({isOpen, onClose, uid, dc}: Props) => {
  const [renderModal, setRenderModal] = useState(isOpen);
  const [openModal, setOpenModal] = useState(false);
  const [animateUp, setAnimateUp] = useState(false);
  const modalRef = useRef<HTMLDivElement>(null);
  const formRef = useRef<HTMLFormElement>(null);
  const modalPanelRef = useRef<HTMLDivElement>(null);

  useOutsideClick(modalPanelRef, onClose);

  useEffect(() => {
    let animateTimeout: NodeJS.Timeout;
    if (isOpen) {
      // Add modal-open class (to animate) after modal is added to the DOM
      setRenderModal(true);
      animateTimeout = setTimeout(() => setOpenModal(true), 300);
    } else {
      setOpenModal(false);
      // Animate modal out before removing from the DOM
      const modal = modalRef.current;
      if (modal) {
        modal.addEventListener('transitionend', () => {
          animateTimeout = setTimeout(() => {
            setRenderModal(false);
            setAnimateUp(false);
          }, 300);
        }, { once: true });
      }
    }
    return () => {
      clearTimeout(animateTimeout);
    };
  }, [isOpen]);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    const formData = new FormData(formRef.current!);
    // Support comma delimated email input or single emails
    // ex: "david@example.com, another@example.com"
    const to = formData.get('to')?.toString()!.trim()
      .split(',').map(email => email.trim())!
    const subject = formData.get('subject')?.toString()
    const content = formData.get('body')?.toString()

    const emailResponse = await createEmail(dc, {
      fromUid: uid,
      subject,
      content,
    })

    const emailId = emailResponse.data.email_insert.id;
    /**
     * Note: This needs to be controlled by a security policy which
     * will be coming in an update soon.
     */
    const uidResponse = await getUidByEmail(dc, {
      emails: to
    })

    /**
     * Note: This is a work around until we support batch inserts. This
     * will eventually be handled in the API.
     */
    const uidPromises = uidResponse.data.users.map((user: any) => {
      return createRecipient(dc, {
        emailId,
        uid: user.uid
      })
    })

    await Promise.all(uidPromises);

    let submitTimeout: NodeJS.Timeout;
    setTimeout(() => {
      setAnimateUp(true);
      onClose();
    }, 200);
    return () => {
      clearTimeout(submitTimeout);
    };
  };

  useEffect(() => {
  const handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Escape') {
      onClose();
    }
  };
  document.addEventListener('keydown', handleKeyDown);
  return () => {
    document.removeEventListener('keydown', handleKeyDown);
  };
}, [onClose]);

  if (!renderModal) {
    return null;
  }

  return (
    <div ref={modalRef} className={`modal ${openModal ? 'modal-open' : ''}`}>
      {/* modal backdrop */}
      <div className="modal-backdrop" />
      {/* modal panel */}
      <div ref={modalPanelRef} className={`${animateUp ? 'animate-up' : ''} modal-panel`}>
        <button onClick={onClose} className="button float-right">
          <Image src="/close.svg" alt="Close" width="20" height="20" />
        </button>
        <h2 className="font-medium text-2xl font-display mb-4 mt-1.5">New Message</h2>
        <form ref={formRef} className="compose-form">
          <label className="form-label">
            <span className="form-label-span">To</span>
            <input 
              className="w-full"
              type="email" 
              name="to" 
              required 
            />
          </label>
          <label className="form-label">
            <span className="form-label-span">Subject</span>
            <input className="w-full" type="text" name="subject" required />
          </label>
          <textarea className='form-body' name="body" required></textarea>
          <div className="ml-auto flex gap-2">
            <button type="button" onClick={onClose} className="button">Cancel</button>
            <button type="submit" onClick={handleSubmit} className="button button-primary">
              Send
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

export default ComposeModal;