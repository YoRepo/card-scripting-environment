--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔导书的奇迹  (ID: 43841694)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 4206
--
-- Effect Text:
-- 选择自己墓地1只魔法师族超量怪兽和从游戏中除外的最多2张自己的名字带有「魔导书」的魔法卡才能发动。选择的怪兽特殊召唤，把选择的名字带有「魔导书」的魔法卡在那只怪兽下面重叠作为超量素材。「魔导书的奇迹」
-- 在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--魔導書の奇跡
function c43841694.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,43841694+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c43841694.target)
	e1:SetOperation(c43841694.activate)
	c:RegisterEffect(e1)
end
function c43841694.filter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c43841694.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL) and c:IsCanOverlay()
end
function c43841694.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c43841694.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.IsExistingTarget(c43841694.filter2,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c43841694.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,c43841694.filter2,tp,LOCATION_REMOVED,0,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,1,0,0)
end
function c43841694.ovfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL) and c:IsCanOverlay()
end
function c43841694.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=e:GetLabelObject()
	local sg=g:Filter(c43841694.ovfilter,tc,e)
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.BreakEffect()
		if sg:GetCount()>0 then
			Duel.Overlay(tc,sg)
		end
	end
end
