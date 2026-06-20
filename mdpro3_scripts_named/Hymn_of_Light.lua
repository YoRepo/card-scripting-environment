--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 祝祷的圣歌  (ID: 80566312)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「龙姬神 萨菲拉」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到6以上的怪兽解放，从手卡把「龙姬神 萨菲拉」仪式召唤。
-- ②：自己场上的仪式怪兽被战斗·效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--祝祷の聖歌
function c80566312.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,56350972)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c80566312.reptg)
	e1:SetValue(c80566312.repval)
	e1:SetOperation(c80566312.repop)
	c:RegisterEffect(e1)
end
function c80566312.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_RITUAL)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c80566312.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c80566312.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c80566312.repval(e,c)
	return c80566312.repfilter(c,e:GetHandlerPlayer())
end
function c80566312.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
