--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 垂直着陆  (ID: 904185)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把衍生物以外的自己场上的风属性怪兽任意数量解放才能发动。解放的怪兽数量的「幻兽机衍生物」（机械族·风·3星·攻/守0）在自己场上特殊召唤。「垂直着陆」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--垂直着陸
function c904185.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,904185+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c904185.cost)
	e1:SetTarget(c904185.target)
	e1:SetOperation(c904185.activate)
	c:RegisterEffect(e1)
end
function c904185.rfilter(c,ft,tp)
	return c:IsAttribute(ATTRIBUTE_WIND) and not c:IsType(TYPE_TOKEN)
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) and (c:IsControler(tp) or c:IsFaceup())
end
function c904185.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c904185.rfilter,1,nil,ft,tp) end
	local maxc=10
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then maxc=1 end
	local g=Duel.SelectReleaseGroup(tp,c904185.rfilter,1,maxc,nil,ft,tp)
	e:SetLabel(g:GetCount())
	Duel.Release(g,REASON_COST)
end
function c904185.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,e:GetLabel(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,e:GetLabel(),0,0)
end
function c904185.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<e:GetLabel() then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		for i=1,e:GetLabel() do
			local token=Duel.CreateToken(tp,904186)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
end
