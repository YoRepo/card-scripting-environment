--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 眼球大王  (ID: 16768387)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1200 | DEF 1000
--
-- Effect Text:
-- 反转：从自己卡组上面把最多5张卡确认，用喜欢的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--大王目玉
function c16768387.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16768387,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c16768387.operation)
	c:RegisterEffect(e1)
end
function c16768387.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.min(5,Duel.GetFieldGroupCount(tp,LOCATION_DECK,0))
	if ct==0 then return end
	local t={}
	for i=1,ct do
		t[i]=i
	end
	local ac=1
	if ct>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(16768387,1))
		ac=Duel.AnnounceNumber(tp,table.unpack(t))
	end
	Duel.SortDecktop(tp,tp,ac)
end
