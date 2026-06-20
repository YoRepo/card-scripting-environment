--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 布局上钩拳  (ID: 19590644)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己怪兽被战斗破坏时才能发动。把持有那只怪兽的攻击力以下的攻击力的1只怪兽从手卡·卡组里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--セットアッパー
function c19590644.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,19590644+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c19590644.condition)
	e1:SetTarget(c19590644.target)
	e1:SetOperation(c19590644.activate)
	c:RegisterEffect(e1)
end
function c19590644.cfilter(c,tp)
	return c:IsPreviousControler(tp)
end
function c19590644.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:Filter(c19590644.cfilter,nil,tp):GetFirst()
	if not tc then return false end
	local atk=tc:GetAttack()
	if atk<0 then atk=0 end
	e:SetLabel(atk)
	return true
end
function c19590644.spfilter(c,e,tp,atk)
	return c:IsAttackBelow(atk) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c19590644.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c19590644.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,e:GetLabel()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c19590644.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c19590644.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,e:GetLabel())
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)~=0 then
		Duel.ConfirmCards(1-tp,g)
	end
end
