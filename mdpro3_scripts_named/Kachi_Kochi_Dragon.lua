--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 硬梆龙  (ID: 69069911)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Dragon
-- Rank 4
-- ATK 2100 | DEF 1300
--
-- Effect Text:
-- 4星怪兽×2
-- 这张卡战斗破坏对方怪兽送去墓地时，可以把这张卡1个超量素材取除，只有1次继续攻击。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--カチコチドラゴン
function c69069911.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69069911,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1)
	e1:SetCondition(c69069911.atcon)
	e1:SetCost(c69069911.atcost)
	e1:SetOperation(c69069911.atop)
	c:RegisterEffect(e1)
end
function c69069911.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c69069911.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c69069911.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
