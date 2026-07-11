--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Bujingi Boar  (ID: 42551040)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1100 | DEF 1900
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Bujin" monster: You can banish this card from your Graveyard, then target 1
-- face-up Attack Position monster your opponent controls; change it to face-up Defense Position, and
-- if you do, its DEF becomes 0 until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--武神器－イクタ
function c42551040.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42551040,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c42551040.poscon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c42551040.postg)
	e1:SetOperation(c42551040.posop)
	c:RegisterEffect(e1)
end
function c42551040.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x88)
end
function c42551040.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c42551040.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c42551040.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c42551040.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c42551040.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42551040.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c42551040.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c42551040.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
