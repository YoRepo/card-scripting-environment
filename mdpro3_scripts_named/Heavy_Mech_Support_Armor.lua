--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 强化支援机械·重装铠甲  (ID: 39890958)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 500
--
-- Effect Text:
-- ①：这张卡召唤成功的场合，以自己墓地1只同盟怪兽为对象才能发动。那只怪兽特殊召唤。
-- ②：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只机械族怪兽为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ③：装备怪兽不会成为对方的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--強化支援メカ・ヘビーアーマー
function c39890958.initial_effect(c)
	aux.EnableUnionAttribute(c,c39890958.filter)
	--untargetable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(39890958,2))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetTarget(c39890958.sumtg)
	e5:SetOperation(c39890958.sumop)
	c:RegisterEffect(e5)
end
c39890958.has_text_type=TYPE_UNION
function c39890958.filter(c)
	return c:IsRace(RACE_MACHINE)
end
function c39890958.spfilter(c,e,tp)
	return c:IsType(TYPE_UNION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c39890958.sumtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39890958.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c39890958.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c39890958.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c39890958.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
