--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 起翼升阶魔法-急袭猛禽之力  (ID: 38044854)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 12189845
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己·对方的主要阶段以及对方战斗阶段，以包含场上的怪兽的自己的场上·墓地的「急袭猛禽」超量怪兽2只以上为对象才能发动。把持有和那2只以上的怪兽的阶级合计相同阶级的1只「急袭猛禽」超量怪兽当作超量召
-- 唤从额外卡组特殊召唤，把作为对象的怪兽作为那超量素材（作为对象的怪兽持有超量素材的场合，那些也全部作为超量素材）。
--[[ __CARD_HEADER_END__ ]]

--ЯRUM－レイド・ラプターズ・フォース
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2 or Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function s.filter1(c,e)
	return c:GetRank()>0 and c:IsFaceup() and c:IsSetCard(0xba) and c:IsCanBeEffectTarget(e) and not c:IsForbidden()
end
function s.filter2(c,e,tp,mg)
	local rk=mg:GetSum(Card.GetRank)
	return c:IsRank(rk) and c:IsSetCard(0xba) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function s.fselect(g,tp,e)
	return g:IsExists(Card.IsLocation,1,nil,LOCATION_MZONE) and Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,g)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local rg=Duel.GetMatchingGroup(s.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,e)
	if chk==0 then return rg:CheckSubGroup(s.fselect,2,99,tp,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=rg:SelectSubGroup(tp,s.fselect,false,2,99,tp,e)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,sg:Filter(Card.IsLocation,nil,LOCATION_GRAVE),1,0,0)
end
function s.ovfilter(c,e)
	return c:IsCanOverlay() and not c:IsImmuneToEffect(e)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetTargetsRelateToChain()
	if tg:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,s.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tg)
	local sc=sg:GetFirst()
	if sc and Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0 then
		sc:CompleteProcedure()
		local og=tg:Filter(s.ovfilter,nil,e)
		for tc in aux.Next(og) do
			local mg=tc:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(sc,mg)
			end
			Duel.Overlay(sc,Group.FromCards(tc))
		end
	end
end
