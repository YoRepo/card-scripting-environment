--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 复制植物  (ID: 66457407)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Plant
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 1回合1次，选择这张卡以外的场上1只植物族怪兽才能发动。这张卡的等级直到结束阶段时变成和选择的怪兽相同等级。
--[[ __CARD_HEADER_END__ ]]

--コピー・プラント
function c66457407.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66457407,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c66457407.lvtg)
	e1:SetOperation(c66457407.lvop)
	c:RegisterEffect(e1)
end
function c66457407.lvfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c:GetLevel()>0
end
function c66457407.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc~=e:GetHandler() and chkc:IsLocation(LOCATION_MZONE) and c66457407.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66457407.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c66457407.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
end
function c66457407.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
