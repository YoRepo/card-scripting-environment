--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电子界男巫  (ID: 36033786)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 4
-- ATK 1800 | DEF 800
-- Setcode: 147
--
-- Effect Text:
-- ①：1回合1次，以对方场上1只攻击表示怪兽为对象才能发动。那只怪兽变成守备表示。这个效果变成守备表示的回合，自己怪兽只能向作为对象的怪兽攻击，自己的电子界族怪兽向作为对象的守备表示怪兽攻击的场合，给与
-- 对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--サイバース・ウィザード
function c36033786.initial_effect(c)
	--change pos
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetDescription(aux.Stringid(36033786,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c36033786.postg)
	e1:SetOperation(c36033786.posop)
	c:RegisterEffect(e1)
end
function c36033786.posfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c36033786.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c36033786.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c36033786.posfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c36033786.posfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c36033786.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)~=0 then
		local fid=tc:GetRealFieldID()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		e2:SetValue(c36033786.atklimit)
		e2:SetLabel(fid)
		Duel.RegisterEffect(e2,tp)
		--pierce
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_PIERCE)
		e3:SetTargetRange(LOCATION_MZONE,0)
		e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_CYBERSE))
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
	end
end
function c36033786.atklimit(e,c)
	return c:GetRealFieldID()~=e:GetLabel()
end
