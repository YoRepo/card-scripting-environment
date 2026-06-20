--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 拦路的强敌  (ID: 92854392)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方进行攻击宣言时这张卡才能发动。选择自己场上1张表侧表示的怪兽。这张卡发动回合，对方只能以所选择的这只怪兽为攻击对象，且必须用所有表侧攻击表示的怪兽攻击所选择的这只怪兽。
--[[ __CARD_HEADER_END__ ]]

--立ちはだかる強敵
function c92854392.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c92854392.condition)
	e1:SetTarget(c92854392.target)
	e1:SetOperation(c92854392.activate)
	c:RegisterEffect(e1)
end
function c92854392.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c92854392.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttackTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc~=at end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,at)
end
function c92854392.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local fid=tc:GetRealFieldID()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_MUST_ATTACK)
		e1:SetTargetRange(0,LOCATION_MZONE)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
		e2:SetValue(c92854392.atklimit)
		e2:SetLabel(fid)
		Duel.RegisterEffect(e2,tp)
		Duel.ChangeAttackTarget(tc)
	end
end
function c92854392.atklimit(e,c)
	return c:GetRealFieldID()==e:GetLabel()
end
