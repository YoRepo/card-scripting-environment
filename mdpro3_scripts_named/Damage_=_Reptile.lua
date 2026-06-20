--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 伤害=爬虫  (ID: 44584775)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 1回合1次，爬虫类族怪兽的战斗让自己受到战斗伤害时才能发动。把持有那个时候受到的伤害数值以下的攻击力的1只爬虫类族怪兽从卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダメージ＝レプトル
function c44584775.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44584775,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c44584775.condition)
	e2:SetTarget(c44584775.target)
	e2:SetOperation(c44584775.activate)
	c:RegisterEffect(e2)
end
function c44584775.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return ep==tp and (a:IsRace(RACE_REPTILE) or (d and d:IsRace(RACE_REPTILE)))
end
function c44584775.filter(c,e,tp,dam)
	return c:IsAttackBelow(dam) and c:IsRace(RACE_REPTILE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44584775.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44584775.filter,tp,LOCATION_DECK,0,1,nil,e,tp,ev) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c44584775.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c44584775.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ev)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
