--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 英豪挑战者 斯巴达兵  (ID: 50491121)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 1000
-- Setcode: 4207
--
-- Effect Text:
-- 1回合1次，对方怪兽的攻击宣言时选择这张卡以外的自己场上1只名字带有「英豪」的怪兽才能发动。这张卡的攻击力直到战斗阶段结束时上升选择的怪兽的原本攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--H・C スパルタス
function c50491121.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50491121,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1)
	e1:SetCondition(c50491121.atkcon)
	e1:SetTarget(c50491121.atktg)
	e1:SetOperation(c50491121.atkop)
	c:RegisterEffect(e1)
end
function c50491121.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c50491121.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6f)
end
function c50491121.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c50491121.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c50491121.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c50491121.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c50491121.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
