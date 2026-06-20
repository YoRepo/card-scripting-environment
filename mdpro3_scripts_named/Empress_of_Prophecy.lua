--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔导皇圣 特莉丝  (ID: 770365)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Spellcaster
-- Rank 5
-- ATK 2000 | DEF 1700
-- Setcode: 110
--
-- Effect Text:
-- 魔法师族5星怪兽×2
-- 这张卡的攻击力上升自己场上的超量素材数量×300的数值。此外，1回合1次，把这张卡1个超量素材取除才能发动。把自己卡组洗切。那之后，从卡组上面把5张卡翻开，选最多有那之中的名字带有「魔导书」的卡数量的
-- 场上的怪兽破坏。那之后，翻开的卡用喜欢的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--魔導皇聖 トリス
function c770365.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),5,2)
	c:EnableReviveLimit()
	--atklimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c770365.atkval)
	c:RegisterEffect(e1)
	--confiem
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(770365,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c770365.cost)
	e2:SetTarget(c770365.target)
	e2:SetOperation(c770365.operation)
	c:RegisterEffect(e2)
end
function c770365.atkval(e,c)
	return Duel.GetOverlayCount(c:GetControler(),1,0)*300
end
function c770365.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c770365.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5 end
end
function c770365.filter(c)
	return c:IsSetCard(0x106e)
end
function c770365.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	local ct=g:FilterCount(c770365.filter,nil)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if ct>0 and sg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=sg:Select(tp,1,ct,nil)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
		Duel.BreakEffect()
	end
	Duel.SortDecktop(tp,tp,5)
end
