--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 龙大神  (ID: 63737050)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Wyrm
-- Level 8
-- ATK 2900 | DEF 1200
--
-- Effect Text:
-- ①：对方对怪兽的特殊召唤成功的场合发动。对方选额外卡组1张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--龍大神
function c63737050.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63737050,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c63737050.condition)
	e1:SetTarget(c63737050.target)
	e1:SetOperation(c63737050.operation)
	c:RegisterEffect(e1)
end
function c63737050.cfilter(c,tp)
	return c:IsSummonPlayer(1-tp)
end
function c63737050.condition(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c63737050.cfilter,1,nil,tp)
end
function c63737050.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_EXTRA)
end
function c63737050.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,nil)
	if tg:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local g=tg:Select(1-tp,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
