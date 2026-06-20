--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 电脑网交叉清除  (ID: 77449773)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- ①：把自己场上1只电子界族怪兽解放，以场上1张卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・クロスワイプ
function c77449773.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(c77449773.cost)
	e1:SetTarget(c77449773.target)
	e1:SetOperation(c77449773.activate)
	c:RegisterEffect(e1)
end
function c77449773.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c77449773.desfilter(c,tc,ec)
	return c:GetEquipTarget()~=tc and c~=ec
end
function c77449773.costfilter(c,ec,tp)
	return c:IsRace(RACE_CYBERSE) and Duel.IsExistingTarget(c77449773.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,c,ec)
end
function c77449773.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() end
	if chk==0 then
		if e:GetLabel()==1 then
			e:SetLabel(0)
			return Duel.CheckReleaseGroup(tp,c77449773.costfilter,1,c,c,tp)
		else
			return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
		end
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local sg=Duel.SelectReleaseGroup(tp,c77449773.costfilter,1,1,c,c,tp)
		Duel.Release(sg,REASON_COST)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c77449773.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
