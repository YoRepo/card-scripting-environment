--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 黑羽-尖锐之布拉  (ID: 16516630)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 5
-- ATK 1300 | DEF 900
-- Setcode: 51
--
-- Effect Text:
-- 把墓地存在的这张卡从游戏中除外，选择自己场上表侧表示存在的1只名字带有「黑羽」的怪兽发动。这个回合选择的怪兽攻击的场合，那次攻击发生的对自己的战斗伤害变成0，选择的怪兽不会被战斗破坏，进行战斗的对方怪
-- 兽在伤害计算后破坏。
--[[ __CARD_HEADER_END__ ]]

--BF－尖鋭のボーラ
function c16516630.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16516630,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c16516630.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c16516630.target)
	e1:SetOperation(c16516630.operation)
	c:RegisterEffect(e1)
end
function c16516630.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c16516630.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
function c16516630.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c16516630.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16516630.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c16516630.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c16516630.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetOperation(c16516630.desop)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e3)
end
function c16516630.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d and d~=e:GetHandler() then Duel.Destroy(d,REASON_EFFECT) end
end
