--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 水精鳞-深渊鲵鱼兵  (ID: 21767650)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 100 | DEF 2000
-- Setcode: 7667828
--
-- Effect Text:
-- 可以把墓地的这张卡从游戏中除外，从以下效果选择1个发动。
-- ●自己场上的全部名字带有「水精鳞」的怪兽的等级上升1星。
-- ●自己场上的全部名字带有「水精鳞」的怪兽的等级上升2星。
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスマンダー
function c21767650.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21767650,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c21767650.lvtg)
	e1:SetOperation(c21767650.lvop)
	c:RegisterEffect(e1)
end
function c21767650.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x74) and c:IsLevelAbove(0)
end
function c21767650.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21767650.filter,tp,LOCATION_MZONE,0,1,nil) end
	local opt=Duel.SelectOption(tp,aux.Stringid(21767650,1),aux.Stringid(21767650,2))
	e:SetLabel(opt)
end
function c21767650.lvop(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local g=Duel.GetMatchingGroup(c21767650.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(opt+1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
