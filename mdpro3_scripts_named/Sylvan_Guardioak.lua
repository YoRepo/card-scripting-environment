--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 森罗的番人 橡树  (ID: 99429730)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 6
-- ATK 2400 | DEF 1500
-- Setcode: 144
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时才能发动。从自己卡组上面把最多3张卡翻开。翻开的卡之中有植物族怪兽的场合，那些卡全部送去墓地。剩下的卡用喜欢的顺序回到卡组最下面。此外，卡组的这张卡被卡的效果翻开送去墓地的
-- 场合，可以从自己墓地选择这张卡以外的1只植物族怪兽回到卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--森羅の番人 オーク
function c99429730.initial_effect(c)
	--deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99429730,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c99429730.target)
	e1:SetOperation(c99429730.operation)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99429730,2))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c99429730.tdcon)
	e2:SetTarget(c99429730.tdtg)
	e2:SetOperation(c99429730.tdop)
	c:RegisterEffect(e2)
end
function c99429730.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c99429730.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>3 then ct=3 end
	local t={}
	for i=1,ct do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(99429730,1))
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.ConfirmDecktop(tp,ac)
	local g=Duel.GetDecktopGroup(tp,ac)
	local sg=g:Filter(Card.IsRace,nil,RACE_PLANT)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_REVEAL)
	end
	ac=ac-sg:GetCount()
	if ac>0 then
		Duel.SortDecktop(tp,tp,ac)
		for i=1,ac do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
		end
	end
end
function c99429730.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_REVEAL)
end
function c99429730.filter(c)
	return c:IsRace(RACE_PLANT) and c:IsAbleToDeck()
end
function c99429730.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c99429730.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99429730.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c99429730.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c99429730.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
