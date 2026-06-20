--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 弦魔人 跃跃节奏  (ID: 26563200)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Fiend
-- Rank 3
-- ATK 1500 | DEF 1000
-- Setcode: 109
--
-- Effect Text:
-- 3星怪兽×2
-- 自己场上的名字带有「魔人」的超量怪兽向对方怪兽攻击的伤害步骤时，把这张卡1个超量素材取除才能发动。那只攻击怪兽的攻击力直到结束阶段时变成2倍。「弦魔人 跃跃节奏」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--弦魔人ムズムズリズム
function c26563200.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26563200,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,26563200)
	e1:SetCondition(c26563200.atkcon)
	e1:SetCost(c26563200.atkcost)
	e1:SetOperation(c26563200.atkop)
	c:RegisterEffect(e1)
end
function c26563200.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsRelateToBattle() and tc:IsSetCard(0x6d) and tc:IsType(TYPE_XYZ) and Duel.GetAttackTarget()~=nil
end
function c26563200.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c26563200.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
	end
end
