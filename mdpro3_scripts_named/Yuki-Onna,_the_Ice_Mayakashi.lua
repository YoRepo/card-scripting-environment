--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Yuki-Onna, the Ice Mayakashi  (ID: 66870733)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Zombie
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1900
-- Setcode: 0x121
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "Mayakashi" monsters
-- You can only control 1 "Yuki-Onna, the Ice Mayakashi".
-- While this card points to a Synchro Monster(s), your opponent's monsters cannot target this card for
-- attacks.
-- If a Synchro Monster(s) in your possession is destroyed by battle or an opponent's card effect while
-- this card is on the field: You can target 1 face-up monster on the field; its ATK/DEF become half
-- its current ATK/DEF until the end of this turn.
-- You can only use this effect of "Yuki-Onna, the Ice Mayakashi" once per turn.
--[[ __CARD_HEADER_END__ ]]

--氷の魔妖－雪女
function c66870733.initial_effect(c)
	c:SetUniqueOnField(1,0,66870733)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x121),2,2)
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c66870733.imcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--atk/def down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66870733,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,66870733)
	e2:SetCondition(c66870733.atkcon)
	e2:SetTarget(c66870733.atktg)
	e2:SetOperation(c66870733.atkop)
	c:RegisterEffect(e2)
end
function c66870733.imfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c66870733.imcon(e)
	return e:GetHandler():GetLinkedGroup():IsExists(c66870733.imfilter,1,nil)
end
function c66870733.atkfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousTypeOnField()&TYPE_SYNCHRO~=0
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function c66870733.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66870733.atkfilter,1,nil,tp)
end
function c66870733.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsFaceup() and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c66870733.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(math.ceil(tc:GetDefense()/2))
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
