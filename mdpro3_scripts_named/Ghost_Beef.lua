--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鬼牛肉  (ID: 84046493)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Beast
-- Level 7
-- Pendulum Scales: L4 / R4
-- ATK 2000 | DEF 1000
--
-- Effect Text:
-- ←4 【灵摆】 4→
-- ①：1回合1次，自己主要阶段才能发动。掷1次骰子。直到回合结束时，这张卡的灵摆刻度上升出现的数目数值（最多到10）。
-- 【怪兽描述】
-- 属于美食家的牛类幽灵。对最爱吃的烤牛肉特别着迷，今天也是为与新味道相遇而一边满怀喜悦一边游荡于现世。
--[[ __CARD_HEADER_END__ ]]

--ゴースト・ビーフ
function c84046493.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84046493,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c84046493.sctg)
	e1:SetOperation(c84046493.scop)
	c:RegisterEffect(e1)
end
function c84046493.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLeftScale()<10 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c84046493.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:GetLeftScale()>=10 then return end
	local dc=Duel.TossDice(tp,1)
	local sch=math.min(10-c:GetLeftScale(),dc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LSCALE)
	e1:SetValue(sch)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(e2)
end
