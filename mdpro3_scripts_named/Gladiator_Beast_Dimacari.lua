--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 剑斗兽 双斗  (ID: 31247589)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 4121
--
-- Effect Text:
-- 这张卡用名字带有「剑斗兽」的怪兽的效果特殊召唤成功的场合，这张卡在同1次的战斗阶段中可以作2次攻击。这张卡进行战斗的战斗阶段结束时可以让这张卡回到卡组，从卡组把「剑斗兽
-- 双斗」以外的1只名字带有「剑斗兽」的怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣ディカエリィ
function c31247589.initial_effect(c)
	--double attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetCondition(c31247589.dacon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31247589,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c31247589.spcon)
	e2:SetCost(c31247589.spcost)
	e2:SetTarget(c31247589.sptg)
	e2:SetOperation(c31247589.spop)
	c:RegisterEffect(e2)
end
function c31247589.dacon(e)
	return e:GetHandler():GetFlagEffect(31247589)>0
end
function c31247589.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c31247589.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeckAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c31247589.filter(c,e,tp)
	return not c:IsCode(31247589) and c:IsSetCard(0x1019) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c31247589.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c31247589.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c31247589.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c31247589.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
	end
end
