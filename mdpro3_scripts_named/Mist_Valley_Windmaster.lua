--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 霞之谷的风使  (ID: 92933195)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level 2
-- ATK 400 | DEF 800
-- Setcode: 55
--
-- Effect Text:
-- 双方手卡有5张以上的场合才能发动。双方玩家直到手卡变成4张把手卡送去墓地。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--霞の谷の風使い
function c92933195.initial_effect(c)
	--hand adjust
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92933195,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c92933195.handcon)
	e1:SetOperation(c92933195.handop)
	c:RegisterEffect(e1)
end
function c92933195.handcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=5 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>=5
end
function c92933195.handop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local ht1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ht1>=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,ht1-4,ht1-4,nil)
		g:Merge(sg)
	end
	local ht2=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	if ht2>=5 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(1-tp,aux.TRUE,1-tp,LOCATION_HAND,0,ht2-4,ht2-4,nil)
		g:Merge(sg)
	end
	Duel.SendtoGrave(g,REASON_EFFECT)
end
