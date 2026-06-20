--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 森罗的灵峰  (ID: 70222318)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 144
--
-- Effect Text:
-- 自己的主要阶段时把手卡或者自己场上表侧表示存在的1只植物族怪兽送去墓地才能发动。从卡组选1张名字带有「森罗」的卡在卡组最上面放置。「森罗的灵峰」的这个效果1回合只能使用1次。此外，对方的结束阶段时只有
-- 1次，可以把自己卡组最上面的卡翻开。翻开的卡是植物族怪兽的场合，那张卡送去墓地。不是的场合，那张卡回到卡组最上面或者最下面。
--[[ __CARD_HEADER_END__ ]]

--森羅の霊峰
function c70222318.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,70222318)
	e2:SetCost(c70222318.cost)
	e2:SetTarget(c70222318.target)
	e2:SetOperation(c70222318.operation)
	c:RegisterEffect(e2)
	--deck check
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(70222318,3))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c70222318.tgcon)
	e3:SetTarget(c70222318.tgtg)
	e3:SetOperation(c70222318.tgop)
	c:RegisterEffect(e3)
end
function c70222318.cfilter(c)
	return c:IsRace(RACE_PLANT) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
end
function c70222318.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70222318.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c70222318.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c70222318.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK,0,1,nil,0x90) end
end
function c70222318.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(70222318,0))
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,1,1,nil,0x90)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
function c70222318.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c70222318.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c70222318.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		local opt=Duel.SelectOption(tp,aux.Stringid(70222318,1),aux.Stringid(70222318,2))
		if opt==1 then
			Duel.MoveSequence(tc,opt)
		end
	end
end
