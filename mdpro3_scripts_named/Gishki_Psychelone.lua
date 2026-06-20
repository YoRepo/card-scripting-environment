--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 邪遗式魂灵座甲魔  (ID: 30334522)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Fiend
-- Level 4
-- ATK 2150 | DEF 1650
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式魔法卡降临。1回合1次，宣言怪兽的种族·属性才能发动。把对方手卡随机1张确认，宣言的种族·属性的怪兽的场合，那张卡回到持有者卡组。不是的场合回到原状。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・プシュケローネ
function c30334522.initial_effect(c)
	c:EnableReviveLimit()
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30334522,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c30334522.target)
	e1:SetOperation(c30334522.operation)
	c:RegisterEffect(e1)
end
function c30334522.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL)
	e:SetLabel(rc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local at=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	Duel.SetTargetParam(at)
end
function c30334522.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1):GetFirst()
	Duel.ConfirmCards(tp,tc)
	local rc=e:GetLabel()
	local at=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tc:IsRace(rc) and tc:IsAttribute(at) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	else Duel.ShuffleHand(1-tp) end
end
