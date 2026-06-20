--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 同调磁铁头  (ID: 50702124)
-- Type: Monster / Effect / Tuner / SpecialSummon
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 1000 | DEF 600
-- Setcode: 23
--
-- Effect Text:
-- 这张卡不能通常召唤。自己对同调怪兽的同调召唤成功时，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--シンクロ・マグネーター
function c50702124.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50702124,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c50702124.spcon)
	e1:SetTarget(c50702124.sptg)
	e1:SetOperation(c50702124.spop)
	c:RegisterEffect(e1)
end
function c50702124.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsControler(tp) and tc:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c50702124.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c50702124.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
		c:CompleteProcedure()
	end
end
