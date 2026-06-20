--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暗黑神秘学  (ID: 14386013)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：丢弃1张手卡才能发动。从自己的卡组·墓地选1张「通灵盘」或者1只恶魔族·8星怪兽加入手卡。
-- ②：把墓地的这张卡除外才能发动。从自己的手卡·墓地的「通灵盘」以及「死之信息」卡之中选任意数量（同名卡最多1张），用喜欢的顺序回到卡组下面。那之后，自己从卡组抽出回去的数量。这个效果在这张卡送去墓地的
-- 回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--ダーク・オカルティズム
function c14386013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14386013,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,14386013)
	e1:SetCost(c14386013.cost)
	e1:SetTarget(c14386013.target)
	e1:SetOperation(c14386013.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14386013,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1,14386014)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c14386013.drtg)
	e2:SetOperation(c14386013.drop)
	c:RegisterEffect(e2)
end
function c14386013.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c14386013.thfilter(c)
	return c:IsAbleToHand() and (c:IsCode(94212438) or (c:IsRace(RACE_FIEND) and c:IsLevel(8)))
end
function c14386013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c14386013.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c14386013.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c14386013.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c14386013.drfilter(c)
	return (c:IsCode(94212438) or c:IsSetCard(0x1c)) and c:IsAbleToDeck()
end
function c14386013.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(c14386013.drfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c14386013.drop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c14386013.drfilter),p,LOCATION_HAND+LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	aux.GCheckAdditional=aux.dncheck
	local sg=g:SelectSubGroup(p,aux.TRUE,false,1,Duel.GetFieldGroupCount(p,LOCATION_DECK,0))
	aux.GCheckAdditional=nil
	if sg then
		Duel.ConfirmCards(1-p,sg)
		local ct=aux.PlaceCardsOnDeckBottom(p,sg)
		if ct==0 then return end
		Duel.BreakEffect()
		Duel.Draw(p,ct,REASON_EFFECT)
	end
end
