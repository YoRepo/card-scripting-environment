--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 正义盟军 未知轰击象  (ID: 22371016)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 3
-- ATK 1200 | DEF 800
-- Setcode: 1
--
-- Effect Text:
-- 这张卡和光属性怪兽进行战斗时，把那只怪兽从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--A・O・J アンノウン・クラッシャー
function c22371016.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22371016,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetTarget(c22371016.rmtg)
	e1:SetOperation(c22371016.rmop)
	c:RegisterEffect(e1)
end
function c22371016.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local c=e:GetHandler()
		local a=Duel.GetAttacker()
		if a==c then a=Duel.GetAttackTarget() end
		e:SetLabelObject(a)
		return a and a:IsAttribute(ATTRIBUTE_LIGHT)
	end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c22371016.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
