--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 魔界剧团-插科打诨角色  (ID: 15308295)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- Pendulum Scales: L8 / R8
-- ATK 1000 | DEF 2000
-- Setcode: 4332
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：以对方场上1只怪兽和自己场上1只「魔界剧团」灵摆怪兽为对象才能发动。那2只怪兽的控制权交换。那之后，这张卡破坏。
-- 【怪兽效果】
-- ①：这张卡的战斗发生的对自己的战斗伤害变成0。
-- ②：自己准备阶段发动。这张卡的控制权移给对方。
-- ③：1回合1次，这张卡的控制权转移的场合发动。这张卡的原本持有者可以选自身的魔法与陷阱区域盖放的1张「魔界台本」魔法卡破坏。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－コミック・リリーフ
function c15308295.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15308295,0))
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,15308295)
	e1:SetTarget(c15308295.cttg)
	e1:SetOperation(c15308295.ctop)
	c:RegisterEffect(e1)
	--avoid damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--control
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(15308295,1))
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c15308295.ctcon)
	e4:SetTarget(c15308295.cttg2)
	e4:SetOperation(c15308295.ctop2)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(15308295,2))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_CONTROL_CHANGED)
	e5:SetCountLimit(1)
	e5:SetTarget(c15308295.destg)
	e5:SetOperation(c15308295.desop)
	c:RegisterEffect(e5)
end
function c15308295.ctfilter(c)
	local tp=c:GetControler()
	return c:IsFaceup() and c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM) and c:IsAbleToChangeControler()
		and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c15308295.ctfilter2(c)
	local tp=c:GetControler()
	return c:IsAbleToChangeControler() and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c15308295.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c15308295.ctfilter2,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingTarget(c15308295.ctfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g1=Duel.SelectTarget(tp,c15308295.ctfilter2,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g2=Duel.SelectTarget(tp,c15308295.ctfilter,tp,LOCATION_MZONE,0,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g1,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c15308295.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local a=g:GetFirst()
	local b=g:GetNext()
	if a:IsRelateToEffect(e) and b:IsRelateToEffect(e) and Duel.SwapControl(a,b) then
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c15308295.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c15308295.cttg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c15308295.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.GetControl(c,1-tp)
	end
end
function c15308295.desfilter(c)
	return c:IsFacedown() and c:IsType(TYPE_SPELL) and c:IsSetCard(0x20ec)
end
function c15308295.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,e:GetHandler():GetOwner(),LOCATION_SZONE)
end
function c15308295.desop(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetOwner()
	local g=Duel.GetMatchingGroup(c15308295.desfilter,p,LOCATION_SZONE,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(p,aux.Stringid(15308295,3)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_DESTROY)
		local sg=g:Select(p,1,1,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
