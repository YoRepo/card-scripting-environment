--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 邪遗式双魂海龙  (ID: 71203602)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level 8
-- ATK 2700 | DEF 1500
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式魔法卡降临。这张卡的攻击宣言时，从自己卡组抽1张卡，给双方确认。确认的卡是名字带有「遗式」的怪兽的场合，把对方手卡随机1张确认。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・リヴァイアニマ
function c71203602.initial_effect(c)
	c:EnableReviveLimit()
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71203602,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c71203602.target)
	e1:SetOperation(c71203602.operation)
	c:RegisterEffect(e1)
end
function c71203602.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c71203602.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.Draw(tp,1,REASON_EFFECT)
	if ct==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	Duel.ShuffleHand(tp)
	if tc:IsSetCard(0x3a) and tc:IsType(TYPE_MONSTER) then
		Duel.BreakEffect()
		local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		if g:GetCount()>0 then
			local sg=g:RandomSelect(tp,1)
			Duel.ConfirmCards(tp,sg)
		end
		Duel.ShuffleHand(1-tp)
	end
end
