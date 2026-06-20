--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 电脑网风暴  (ID: 42461852)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- ①：场上的连接状态的怪兽的攻击力·守备力上升500。
-- ②：只要这张卡在场地区域存在，连接怪兽的连接召唤不会被无效化。
-- ③：自己受到2000以上的战斗·效果伤害的场合才能发动。只把自己的额外卡组的里侧表示的卡洗切，那张最上面的卡翻开。翻开的卡是电子界族连接怪兽的场合，那只怪兽特殊召唤。不是的场合回到原状。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・ストーム
function c42461852.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsLinkState))
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--cannot disable summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e4:SetRange(LOCATION_FZONE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsSummonType,SUMMON_TYPE_LINK))
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(42461852,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DAMAGE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(c42461852.spcon)
	e5:SetTarget(c42461852.sptg)
	e5:SetOperation(c42461852.spop)
	c:RegisterEffect(e5)
end
function c42461852.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and ev>=2000
end
function c42461852.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetLocationCountFromEx(tp,tp,nil,TYPE_LINK)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c42461852.spop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSpecialSummon(tp)
		or Duel.GetMatchingGroupCount(Card.IsFacedown,tp,LOCATION_EXTRA,0,nil)==0 then return end
	Duel.ShuffleExtra(tp)
	Duel.ConfirmExtratop(tp,1)
	local tc=Duel.GetExtraTopGroup(tp,1):GetFirst()
	if tc:IsType(TYPE_LINK) and tc:IsRace(RACE_CYBERSE) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
