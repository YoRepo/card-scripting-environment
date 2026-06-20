--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 归魂复仇死者的诞生  (ID: 94666032)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 262
--
-- Effect Text:
-- 「复仇死者」仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放或者作为解放的代替而把自己墓地的不死族怪兽除外，从自己的手卡·墓地把1只「复仇死者」仪式怪兽仪式召唤。
-- ②：自己场上的「归魂复仇死者·屠魔侠」被战斗·效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--リヴェンデット・ボーン
function c94666032.initial_effect(c)
	aux.AddCodeList(c,4388680)
	aux.AddRitualProcGreater2(c,c94666032.filter,LOCATION_HAND+LOCATION_GRAVE,c94666032.mfilter)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c94666032.reptg)
	e2:SetValue(c94666032.repval)
	e2:SetOperation(c94666032.repop)
	c:RegisterEffect(e2)
end
function c94666032.filter(c)
	return c:IsSetCard(0x106)
end
function c94666032.mfilter(c)
	return c:IsRace(RACE_ZOMBIE)
end
function c94666032.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsCode(4388680)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c94666032.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c94666032.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c94666032.repval(e,c)
	return c94666032.repfilter(c,e:GetHandlerPlayer())
end
function c94666032.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
