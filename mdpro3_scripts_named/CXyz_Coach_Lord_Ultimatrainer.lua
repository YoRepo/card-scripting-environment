--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 混沌超量 热血指导神 究极教练  (ID: 88754763)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Warrior
-- Rank 9
-- ATK 3800 | DEF 2300
-- Setcode: 4211
--
-- Effect Text:
-- 9星怪兽×4
-- 场上的这张卡不会成为卡的效果的对象。此外，这张卡有超量怪兽在作为超量素材的场合，得到以下效果。
-- ●1回合1次，把这张卡1个超量素材取除才能发动。从卡组抽1张卡，给双方确认。确认的卡是怪兽的场合，再给与对方基本分800分伤害。
--[[ __CARD_HEADER_END__ ]]

--CX 熱血指導神アルティメットレーナー
function c88754763.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,4)
	c:EnableReviveLimit()
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE)
	e2:SetDescription(aux.Stringid(88754763,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c88754763.condition)
	e2:SetCost(c88754763.cost)
	e2:SetTarget(c88754763.target)
	e2:SetOperation(c88754763.operation)
	c:RegisterEffect(e2)
end
function c88754763.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_XYZ)
end
function c88754763.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c88754763.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c88754763.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.Draw(tp,1,REASON_EFFECT)
	if ct==0 then return end
	local dc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,dc)
	if dc:IsType(TYPE_MONSTER) then
		Duel.BreakEffect()
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end
