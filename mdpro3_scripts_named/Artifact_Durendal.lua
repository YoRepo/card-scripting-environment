--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 古遗物-恒常剑  (ID: 69840739)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank 5
-- ATK 2400 | DEF 2100
-- Setcode: 151
--
-- Effect Text:
-- 5星怪兽×2
-- ①：1回合1次，可以从以下效果选择1个发动。这个效果在对方回合也能发动。
-- ●在场上的怪兽的效果发动时或者在通常魔法·通常陷阱卡发动时，把这张卡1个超量素材取除才能发动。那个效果变成「选对方场上1张魔法·陷阱卡破坏」。
-- ●把这张卡1个超量素材取除才能发动。双方让手卡全部回到卡组洗切。那之后，双方各自从卡组抽出自身回到卡组的数量。
--[[ __CARD_HEADER_END__ ]]

--アーティファクト－デュランダル
function c69840739.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69840739,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCondition(c69840739.chcon)
	e1:SetCost(c69840739.cost)
	e1:SetTarget(c69840739.chtg)
	e1:SetOperation(c69840739.chop)
	c:RegisterEffect(e1)
	--reload
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69840739,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(c69840739.cost)
	e2:SetTarget(c69840739.drtg)
	e2:SetOperation(c69840739.drop)
	c:RegisterEffect(e2)
end
function c69840739.chcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return (re:IsActiveType(TYPE_MONSTER) and loc==LOCATION_MZONE)
		or ((re:GetActiveType()==TYPE_SPELL or re:GetActiveType()==TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c69840739.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c69840739.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69840739.filter,rp,0,LOCATION_ONFIELD,1,nil) end
end
function c69840739.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c69840739.repop)
end
function c69840739.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c69840739.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c69840739.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c69840739.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if chk==0 then return (Duel.IsPlayerCanDraw(tp) or h1==0)
		and (Duel.IsPlayerCanDraw(1-tp) or h2==0)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,PLAYER_ALL,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c69840739.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	if Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 then
		local og=g:Filter(Card.IsLocation,nil,LOCATION_DECK)
		if og:IsExists(Card.IsControler,1,nil,tp) then Duel.ShuffleDeck(tp) end
		if og:IsExists(Card.IsControler,1,nil,1-tp) then Duel.ShuffleDeck(1-tp) end
		Duel.BreakEffect()
		local ct1=og:FilterCount(Card.IsPreviousControler,nil,tp)
		local ct2=og:FilterCount(Card.IsPreviousControler,nil,1-tp)
		Duel.Draw(tp,ct1,REASON_EFFECT)
		Duel.Draw(1-tp,ct2,REASON_EFFECT)
	end
end
