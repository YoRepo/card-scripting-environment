--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: DNA改造手术  (ID: 74701381)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 发动时宣言1个种族。只要这张卡在场上存在，场上的全部表侧表示的怪兽变成宣言的种族。
--[[ __CARD_HEADER_END__ ]]

--DNA改造手術
function c74701381.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c74701381.target)
	c:RegisterEffect(e1)
	--race
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetValue(c74701381.value)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c74701381.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL)
	e:GetLabelObject():SetLabel(rc)
	e:GetHandler():SetHint(CHINT_RACE,rc)
end
function c74701381.value(e,c)
	return e:GetLabel()
end
