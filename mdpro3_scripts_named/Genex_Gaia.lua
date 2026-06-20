--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 次世代地矿人  (ID: 89333528)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 3
-- ATK 1000 | DEF 1900
-- Setcode: 2
--
-- Effect Text:
-- ①：场上的这张卡被战斗·效果破坏的场合，可以作为代替把自己场上1只「次世代控制员」破坏。
--[[ __CARD_HEADER_END__ ]]

--ジェネクス・ガイア
function c89333528.initial_effect(c)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetTarget(c89333528.desreptg)
	e2:SetOperation(c89333528.desrepop)
	c:RegisterEffect(e2)
end
function c89333528.repfilter(c,e)
	return c:IsFaceup() and c:IsCode(68505803)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
end
function c89333528.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c89333528.repfilter,tp,LOCATION_MZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c89333528.repfilter,tp,LOCATION_MZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c89333528.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
