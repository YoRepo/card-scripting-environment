--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 超级运动员最佳球员  (ID: 48636108)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 17236146
--
-- Effect Text:
-- 这个卡名在规则上也当作「方程式运动员」卡使用。这个卡名的卡在1回合只能发动1张。
-- ①：自己的「超级运动员」怪兽或者「方程式运动员」怪兽去用战斗破坏对方怪兽的伤害计算后或者去给与对方战斗伤害时才能发动。从自己的手卡·墓地选「超级运动员」怪兽以及「方程式运动员」怪兽任意数量守备表示特殊
-- 召唤（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--U.A.マン・オブ・ザ・マッチ
function c48636108.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48636108,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCountLimit(1,48636108+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c48636108.spcon)
	e1:SetTarget(c48636108.sptg)
	e1:SetOperation(c48636108.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(48636108,1))
	e2:SetCondition(c48636108.spcon2)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	c:RegisterEffect(e2)
end
function c48636108.filter(c)
	return c:IsSetCard(0xb2,0x107) and c:IsType(TYPE_MONSTER)
end
function c48636108.spfilter(c,e,tp)
	return c48636108.filter(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c48636108.spcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(tp) then a,d=d,a end
	return c48636108.filter(a) and d:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c48636108.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsControler(tp) and c48636108.filter(tc)
end
function c48636108.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c48636108.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c48636108.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c48636108.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
	if ft<=0 or g:GetCount()==0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,ft)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
