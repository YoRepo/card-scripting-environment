--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 邪遗式四臂噬人魔  (ID: 21496848)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level 6
-- ATK 2600 | DEF 2100
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式魔法卡降临。1回合1次，宣言卡的种类（怪兽·魔法·陷阱）才能发动。对方可以丢弃1张手卡让这个效果无效。没丢弃的场合，双方玩家把宣言的种类的1张卡从卡组送去墓地。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・テトラオーグル
function c21496848.initial_effect(c)
	c:EnableReviveLimit()
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21496848,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c21496848.target)
	e1:SetOperation(c21496848.operation)
	c:RegisterEffect(e1)
end
function c21496848.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local ac=Duel.AnnounceType(tp)
	e:SetLabel(ac)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c21496848.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.IsChainDisablable(0)
		and Duel.SelectYesNo(1-tp,aux.Stringid(21496848,4)) then
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		Duel.NegateEffect(0)
		return
	end
	local ty=TYPE_MONSTER
	if e:GetLabel()==1 then ty=TYPE_SPELL
	elseif e:GetLabel()==2 then ty=TYPE_TRAP end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,ty)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(1-tp,Card.IsType,1-tp,LOCATION_DECK,0,1,1,nil,ty)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_EFFECT)
end
