--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 星逢的神篱  (ID: 15306543)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：1回合1次，可以发动。从自己场上的灵魂怪兽以及「灵魂鸟衍生物」之中让等级合计直到变成仪式召唤的怪兽的等级以上为止解放，从卡组把1只风属性仪式怪兽仪式召唤。
-- ②：1回合最多2次，自己场上的表侧表示的风属性怪兽回到自己手卡的场合，可以从以下效果选择1个发动。
-- ●自己的墓地·除外状态的1只灵魂怪兽或1张仪式魔法卡加入手卡。
-- ●从卡组把1张「星逢的天河」在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--星逢の神籬
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--ritual summon
	local t={aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND),Card.GetOriginalLevel,"Greater",LOCATION_DECK,nil,s.mfilter}
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(aux.RitualUltimateTarget(table.unpack(t)))
	e2:SetOperation(aux.RitualUltimateOperation(table.unpack(t)))
	c:RegisterEffect(e2)
	--retrieve/sset, on bounce
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(2)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(s.condition)
	e3:SetTarget(s.target)
	c:RegisterEffect(e3)
end
s.has_text_type=TYPE_SPIRIT
function s.mfilter(c,tp)
	return (c:IsType(TYPE_SPIRIT) or c:IsCode(25415053)) and c:IsLocation(LOCATION_MZONE)
end
function s.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and bit.band(c:GetPreviousAttributeOnField(),ATTRIBUTE_WIND)~=0 and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.filter(c)
	return c:IsFaceupEx() and (c:IsType(TYPE_SPIRIT) or c:GetType()&0x82==0x82) and c:IsAbleToHand()
end
function s.sfilter(c)
	return c:IsCode(20417688) and c:IsSSetable()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(s.sfilter,tp,LOCATION_DECK,0,1,nil)
	if chk==0 then return b1 or b2 end
	local op=aux.SelectFromOptions(tp,{b1,1190},{b2,1153})
	if op==1 then
		e:SetCategory(CATEGORY_TOHAND)
		e:SetOperation(s.retrieve)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
	else
		e:SetCategory(CATEGORY_SSET)
		e:SetOperation(s.ssettrap)
	end
end
function s.retrieve(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.filter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.ssettrap(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tc=Duel.SelectMatchingCard(tp,s.sfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc then Duel.SSet(tp,tc) end
end
