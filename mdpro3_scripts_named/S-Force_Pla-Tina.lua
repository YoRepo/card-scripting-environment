--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 治安战警队 铂金女  (ID: 58363151)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 2200 | DEF 2000
-- Setcode: 342
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合，以「治安战警队 铂金女」以外的除外的1只自己的「治安战警队」怪兽为对象才能发动。那只怪兽特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己的「治安战警队」怪兽的正对面的对方怪兽的攻击力下降600。
--[[ __CARD_HEADER_END__ ]]

--S－Force プラ＝ティナ
function c58363151.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58363151,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,58363151)
	e1:SetTarget(c58363151.sptg)
	e1:SetOperation(c58363151.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--attack down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c58363151.atktg)
	e3:SetValue(-600)
	c:RegisterEffect(e3)
end
function c58363151.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x156) and not c:IsCode(58363151) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c58363151.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c58363151.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c58363151.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c58363151.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c58363151.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c58363151.atkfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x156) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c58363151.atktg(e,c)
	local cg=c:GetColumnGroup()
	return cg:IsExists(c58363151.atkfilter,1,nil,e:GetHandlerPlayer())
end
