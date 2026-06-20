--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 遗式术师·诺艾莉娅  (ID: 63942761)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1700 | DEF 1000
-- Setcode: 58
--
-- Effect Text:
-- 这张卡召唤成功时，可以从自己卡组上面把5张卡翻开。翻开的卡之中有仪式魔法卡或者名字带有「遗式」的怪兽卡的场合，那些卡全部送去墓地。剩下的卡用喜欢的顺序回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--リチュア・ノエリア
function c63942761.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63942761,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c63942761.target)
	e1:SetOperation(c63942761.operation)
	c:RegisterEffect(e1)
end
function c63942761.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
end
function c63942761.filter(c)
	return c:GetType()==0x82 or (c:IsSetCard(0x3a) and c:IsType(TYPE_MONSTER))
end
function c63942761.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,5) then return end
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	local sg=g:Filter(c63942761.filter,nil)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_REVEAL)
	end
	Duel.SortDecktop(tp,tp,5-sg:GetCount())
	for i=1,5-sg:GetCount() do
		local mg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
	end
end
