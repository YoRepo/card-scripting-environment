--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 神秘之吹笛人  (ID: 14198496)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把这张卡解放发动。从自己卡组抽1张卡。这个效果抽到的卡给双方确认，1星怪兽的场合，自己再抽1张卡。「神秘之吹笛人」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ミスティック・パイパー
function c14198496.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14198496,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,14198496)
	e1:SetCost(c14198496.cost)
	e1:SetTarget(c14198496.target)
	e1:SetOperation(c14198496.operation)
	c:RegisterEffect(e1)
end
function c14198496.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c14198496.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c14198496.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.Draw(tp,1,REASON_EFFECT)
	if ct==0 then return end
	local dc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,dc)
	if dc:IsLevel(1) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end
