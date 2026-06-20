--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机械天使的仪式  (ID: 39996157)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 292
--
-- Effect Text:
-- 「电子化天使」仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「电子化天使」仪式怪兽仪式召唤。
-- ②：自己场上的光属性怪兽被战斗·效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--機械天使の儀式
function c39996157.initial_effect(c)
	aux.AddRitualProcGreater2(c,c39996157.ritual_filter)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c39996157.reptg)
	e2:SetValue(c39996157.repval)
	e2:SetOperation(c39996157.repop)
	c:RegisterEffect(e2)
end
function c39996157.ritual_filter(c)
	return c:IsSetCard(0x2093)
end
function c39996157.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsAttribute(ATTRIBUTE_LIGHT)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c39996157.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c39996157.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c39996157.repval(e,c)
	return c39996157.repfilter(c,e:GetHandlerPlayer())
end
function c39996157.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
