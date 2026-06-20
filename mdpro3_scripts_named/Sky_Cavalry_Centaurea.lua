--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 神骑 矢车菊圣人马  (ID: 36776089)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Rank 2
-- ATK 2000 | DEF 0
--
-- Effect Text:
-- 2星怪兽×2
-- ①：持有超量素材的这张卡不会被战斗破坏。
-- ②：这张卡和对方怪兽进行战斗的伤害步骤结束时，把这张卡1个超量素材取除才能发动。那只对方怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--神騎セイントレア
function c36776089.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2)
	c:EnableReviveLimit()
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c36776089.incon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36776089,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c36776089.retcon)
	e2:SetCost(c36776089.retcost)
	e2:SetTarget(c36776089.rettg)
	e2:SetOperation(c36776089.retop)
	c:RegisterEffect(e2)
end
function c36776089.incon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c36776089.retcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and c:IsRelateToBattle() and bc:IsRelateToBattle()
end
function c36776089.retcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c36776089.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c36776089.retop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.SendtoHand(bc,nil,REASON_EFFECT)
	end
end
