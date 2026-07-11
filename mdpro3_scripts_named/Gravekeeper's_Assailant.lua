--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gravekeeper's Assailant  (ID: 25262697)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1500 | DEF 1500
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card declares an attack while "Necrovalley" is on the field: You can target 1 face-up
-- monster your opponent controls; change that target's battle position.
--[[ __CARD_HEADER_END__ ]]

--墓守の暗殺者
function c25262697.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25262697,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c25262697.poscon)
	e1:SetTarget(c25262697.postg)
	e1:SetOperation(c25262697.posop)
	c:RegisterEffect(e1)
end
function c25262697.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(47355498)
end
function c25262697.filter(c)
	return c:IsFaceup() and c:IsCanChangePosition()
end
function c25262697.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c25262697.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c25262697.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c25262697.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c25262697.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
