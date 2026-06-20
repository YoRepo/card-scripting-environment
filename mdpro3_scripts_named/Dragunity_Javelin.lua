--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 龙骑兵团-标枪龙  (ID: 80549379)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level 2
-- ATK 1200 | DEF 800
-- Setcode: 41
--
-- Effect Text:
-- 这张卡在怪兽卡区域上被破坏的场合，可以不送去墓地当作装备魔法卡使用给自己场上表侧表示存在的1只名字带有「龙骑兵团」的鸟兽族怪兽装备。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－ジャベリン
function c80549379.initial_effect(c)
	--send replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c80549379.repcon)
	e1:SetOperation(c80549379.repop)
	c:RegisterEffect(e1)
end
function c80549379.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x29) and c:IsRace(RACE_WINDBEAST)
end
function c80549379.repcon(e)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
		and Duel.IsExistingMatchingCard(c80549379.filter,tp,LOCATION_MZONE,0,1,c)
end
function c80549379.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,c80549379.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	local tc=g:GetFirst()
	if Duel.Equip(tp,c,tc,false) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c80549379.eqlimit)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	end
end
function c80549379.eqlimit(e,c)
	return c==e:GetLabelObject()
end
