--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 雷电妈妈  (ID: 21524779)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK 1400 | DEF 700
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时才能发动。从手卡把「雷电妈妈」以外的1只雷族·光属性·4星的怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--OKaサンダー
function c21524779.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21524779,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c21524779.target)
	e1:SetOperation(c21524779.operation)
	c:RegisterEffect(e1)
end
function c21524779.filter(c)
	return c:IsRace(RACE_THUNDER) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(4)
		and not c:IsCode(21524779) and c:IsSummonable(true,nil)
end
function c21524779.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21524779.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c21524779.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c21524779.filter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
