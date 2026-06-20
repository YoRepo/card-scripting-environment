--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 电磁蓑衣虫  (ID: 7914843)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Insect
-- Level 3
-- ATK 200 | DEF 1400
--
-- Effect Text:
-- ①：这张卡反转的场合，以对方场上1只机械族怪兽为对象发动。直到下次的自己结束阶段，得到那只机械族怪兽的控制权。
-- ②：这张卡被和怪兽的战斗破坏的场合发动。那只怪兽的攻击力·守备力下降500。
--[[ __CARD_HEADER_END__ ]]

--電磁ミノ虫
function c7914843.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7914843,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c7914843.target)
	e1:SetOperation(c7914843.operation)
	c:RegisterEffect(e1)
	--destroyed
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7914843,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetOperation(c7914843.desop)
	c:RegisterEffect(e2)
end
function c7914843.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsAbleToChangeControler()
end
function c7914843.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c7914843.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c7914843.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c7914843.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsRace(RACE_MACHINE) then
		local tct=1
		if Duel.GetTurnPlayer()~=tp then tct=2
		elseif Duel.GetCurrentPhase()==PHASE_END then tct=3 end
		Duel.GetControl(tc,tp,PHASE_END,tct)
	end
end
function c7914843.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc:IsRelateToBattle() or bc:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(-500)
	bc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	bc:RegisterEffect(e2)
end
