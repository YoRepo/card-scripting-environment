--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 捕食植物 猪笼草翼龙  (ID: 26308721)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 3
-- ATK 300 | DEF 2100
-- Setcode: 4339
--
-- Effect Text:
-- ①：这张卡给与对方战斗伤害时，以对方场上1只表侧表示怪兽为对象才能发动。给那只怪兽放置1个捕食指示物。有捕食指示物放置的2星以上的怪兽的等级变成1星。
-- ②：1回合1次，以持有这张卡的等级以下的等级的对方场上1只怪兽为对象才能发动。那只怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--捕食植物プテロペンテス
function c26308721.initial_effect(c)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26308721,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c26308721.ctcon1)
	e1:SetTarget(c26308721.cttg1)
	e1:SetOperation(c26308721.ctop1)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26308721,1))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c26308721.cttg2)
	e2:SetOperation(c26308721.ctop2)
	c:RegisterEffect(e2)
end
function c26308721.ctcon1(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c26308721.cttg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsCanAddCounter(0x1041,1) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,nil,0x1041,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,1,nil,0x1041,1)
end
function c26308721.ctop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:AddCounter(0x1041,1) and tc:GetLevel()>1 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c26308721.lvcon)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
function c26308721.lvcon(e)
	return e:GetHandler():GetCounter(0x1041)>0
end
function c26308721.ctfilter2(c,mc)
	return c:IsFaceup() and c:IsLevelBelow(mc:GetLevel()) and c:IsControlerCanBeChanged()
end
function c26308721.cttg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c26308721.ctfilter2(chkc,c) end
	if chk==0 then return Duel.IsExistingTarget(c26308721.ctfilter2,tp,0,LOCATION_MZONE,1,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c26308721.ctfilter2,tp,0,LOCATION_MZONE,1,1,nil,c)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c26308721.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
