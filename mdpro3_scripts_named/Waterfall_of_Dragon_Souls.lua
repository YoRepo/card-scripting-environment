--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 幽丽的幻泷  (ID: 23068051)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：可以从以下效果选择1个发动。
-- ●从卡组把1只幻龙族怪兽加入手卡。
-- ●从手卡以及自己场上的表侧表示怪兽之中把幻龙族怪兽任意数量送去墓地才能发动。自己从卡组抽出送去墓地的怪兽的数量＋1张。
--[[ __CARD_HEADER_END__ ]]

--幽麗なる幻滝
function c23068051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23068051,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c23068051.target)
	e1:SetOperation(c23068051.activate)
	c:RegisterEffect(e1)
	--Activate2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23068051,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(c23068051.cost)
	e2:SetTarget(c23068051.target2)
	e2:SetOperation(c23068051.activate2)
	c:RegisterEffect(e2)
end
function c23068051.filter(c)
	return c:IsRace(RACE_WYRM) and c:IsAbleToHand()
end
function c23068051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23068051.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c23068051.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c23068051.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c23068051.filter2(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsRace(RACE_WYRM) and c:IsAbleToGraveAsCost()
end
function c23068051.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23068051.filter2,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil) end
	local ft=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local g=Duel.GetMatchingGroup(c23068051.filter2,tp,LOCATION_MZONE+LOCATION_HAND,0,nil)
	local ct=math.min(ft-1,g:GetCount()+1)
	local sg=g:Select(tp,1,ct,nil)
	e:SetLabel(sg:GetCount()+1)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c23068051.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,e:GetLabel())
end
function c23068051.activate2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
