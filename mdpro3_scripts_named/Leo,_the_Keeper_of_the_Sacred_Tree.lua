--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 神树的守护兽-牙王  (ID: 8561192)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Beast
-- Level 10
-- ATK 3100 | DEF 1900
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡在自己的主要阶段2以外不会成为对方的卡的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--神樹の守護獣－牙王
function c8561192.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetCondition(c8561192.tgcon)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
end
function c8561192.tgcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() or Duel.GetCurrentPhase()~=PHASE_MAIN2
end
