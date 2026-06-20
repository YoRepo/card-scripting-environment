--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 行列怪兽 骑士之桂马  (ID: 41493640)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 3
-- ATK 800 | DEF 400
--
-- Effect Text:
-- 这张卡召唤成功时，选择对方的魔法与陷阱卡区域盖放的1张卡才能发动。把盖放的那张卡确认，陷阱卡的场合，那张卡破坏。不是的场合，回到原状。这个效果把陷阱卡破坏时，可以把以下效果发动。
-- ●从手卡把1只地属性·3星怪兽表侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ラインモンスター Kホース
function c41493640.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41493640,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c41493640.target)
	e1:SetOperation(c41493640.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41493640,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CUSTOM+41493640)
	e2:SetTarget(c41493640.sptg)
	e2:SetOperation(c41493640.spop)
	c:RegisterEffect(e2)
end
function c41493640.filter(c)
	return c:IsFacedown() and c:GetSequence()~=5
end
function c41493640.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_SZONE) and c41493640.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c41493640.filter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,c41493640.filter,tp,0,LOCATION_SZONE,1,1,nil)
end
function c41493640.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsFaceup() then return end
	Duel.ConfirmCards(tp,tc)
	if tc:IsType(TYPE_TRAP) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			Duel.RaiseSingleEvent(c,EVENT_CUSTOM+41493640,e,0,tp,tp,0)
		end
	end
end
function c41493640.spfilter(c,e,tp)
	return c:IsLevel(3) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c41493640.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c41493640.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c41493640.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c41493640.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
